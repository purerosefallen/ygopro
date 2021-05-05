--高速决斗技能-抽卡预感：魔法·陷阱
Duel.LoadScript("speed_duel_common.lua")
function c100730093.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(96316857,c)
	if not c100730093.UsedLP then
		c100730093.UsedLP={}
		c100730093.UsedLP[0]=0
		c100730093.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelReplaceDraw(c,c100730093.skill,c100730093.con,aux.Stringid(100730093,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730093.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730093,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730093)
		c100730093.UsedLP[tp]=c100730093.UsedLP[tp]+1000
		local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_DECK,0,nil,TYPE_SPELL+TYPE_TRAP)
		if not g or g:GetCount()==0 then return end
		g=g:RandomSelect(tp,1)
		Duel.MoveSequence(g:GetFirst(),0)
		e:Reset()
	end
end

function c100730093.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_DECK,0,nil,TYPE_SPELL+TYPE_TRAP)>0
		and aux.DecreasedLP[tp]-c100730093.UsedLP[tp] >= 1000
end