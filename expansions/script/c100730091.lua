--高速决斗技能-增援
Duel.LoadScript("speed_duel_common.lua")
function c100730091.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(52503575,c)
	if not c100730091.UsedLP then
		c100730091.UsedLP={}
		c100730091.UsedLP[0]=0
		c100730091.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelReplaceDraw(c,c100730091.skill,c100730091.con,aux.Stringid(100730091,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730091.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730091,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730091)
		c100730091.UsedLP[tp]=c100730091.UsedLP[tp]+1500
		local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_DECK,0,nil,RACE_WARRIOR)
		if not g or g:GetCount()==0 then return end
		g=g:RandomSelect(tp,1)
		Duel.MoveSequence(g:GetFirst(),0)
		e:Reset()
	end
end

function c100730091.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_DECK,0,nil,RACE_WARRIOR)>0
		and aux.DecreasedLP[tp]-c100730091.UsedLP[tp] >= 1500
end