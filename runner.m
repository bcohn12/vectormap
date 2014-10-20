classdef runner

    properties
        m_n = 0; 
        m_oldM = 0.0;
        m_newM = 0.0;
        m_oldS = 0.0;
        m_newS = 0.0;
    end

    methods 

        function obj = runner()
            m_n=0;
            disp('Generated runner')
                    m_n = 0; 
            m_oldM = 0.0;
            m_newM = 0.0;
            m_oldS = 0.0;
        m_newS = 0.0;
            % all initializations, calls to base class, etc. here,
        end
        function push(x)
            m_n = m_n + 1;
            if m_n == 1
                m_newM = x;
                m_oldM = m_newM
                m_oldS = 0.0;
            
            else
                m_newM = m_oldM + (x - m_oldM)/m_n;
                m_newS = m_oldS + (x - m_oldM)*(x - m_newM);
    
                % // set up for next iteration
                m_oldM = m_newM; 
                m_oldS = m_newS;
            end

        end
        function mean()
            return m_newM
        end
        function variance()
            return m_newS/(m_n -1)
        end
        function std()
            return sqrt(Variance());
        end
    end    
end