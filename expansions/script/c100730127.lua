--高速决斗技能-我还没有完蛋呢！
Duel.LoadScript("speed_duel_common.lua")
function c100730127.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730127.skill,c100730127.con,aux.Stringid(100730127,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730127.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnCount()>=5 and Duel.GetLP(tp)<3001
end

function c100730127.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local lp=Duel.GetLP(tp)
	if lp>3001 then return end
	if not Duel.SelectYesNo(tp,aux.Stringid(100730127,0)) then return end
		Duel.SetLP(tp,3001)   
end