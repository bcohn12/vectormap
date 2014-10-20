classdef running_var_mean < handle

    properties
        m_n = 0; 
    end

    methods 

        function obj = Cat()
            m_n=0;
            disp('Generated runner')
            % all initializations, calls to base class, etc. here,
        end

        function Meow(obj)
            disp('meowww'); 
            obj.m_n = obj.m_n + 1;
        end
        function Push(x)
            m_n = m_n + 1;
            if m_n == 1
                m_oldM = m_newM = x;
                m_oldS = 0.0;
            
            else
                m_newM = m_oldM + (x - m_oldM)/m_n;
                m_newS = m_oldS + (x - m_oldM)*(x - m_newM);
    
                % // set up for next iteration
                m_oldM = m_newM; 
                m_oldS = m_newS;
            end

        end
    end    
end