--高速决斗技能-注定一抽
Duel.LoadScript("speed_duel_common.lua")
function c100730001.initial_effect(c)
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelReplaceDraw(c,c100730001.skill,c100730001.con,aux.Stringid(100730001,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730001.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730001,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730001)
		Duel.Hint(HINTMSG_SELECT,tp,aux.Stringid(100730001,1))
		local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_DECK,0,1,1,nil)
		if not g then return end
		Duel.MoveSequence(g:GetFirst(),0)
		e:Reset()
	end
end

function c100730001.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp and aux.DecreasedLP[tp] >= 2000
end