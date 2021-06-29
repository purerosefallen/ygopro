--高速决斗技能--生命总会找到出路
Duel.LoadScript("speed_duel_common.lua")
function c100730263.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(54407825,c)
	if not c100730263.UsedLP then
		c100730263.UsedLP={}
		c100730263.UsedLP[0]=0
		c100730263.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelReplaceDraw(c,c100730263.skill,c100730263.con,aux.Stringid(100730263,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730263.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730263,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730263)
		c100730263.UsedLP[tp]=c100730263.UsedLP[tp]+1000
		local g=Duel.GetMatchingGroup(Card.IsRace,tp,LOCATION_DECK,0,nil,RACE_DINOSAUR)
		if not g or g:GetCount()==0 then return end
		g=g:RandomSelect(tp,1)
		Duel.MoveSequence(g:GetFirst(),0)
		e:Reset()
	end
end

function c100730263.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.GetMatchingGroupCount(Card.IsRace,tp,LOCATION_DECK,0,nil,RACE_DINOSAUR)>0
		and aux.DecreasedLP[tp]-c100730263.UsedLP[tp] >= 1000
end